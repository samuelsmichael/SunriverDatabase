USE ComRoster

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Updates the Committee Data table
-- =============================================
alter PROCEDURE uspComRosterCommitteeSet 
	@CommitteeID int = null,
	@CommitteeName nvarchar(45),
	@#OfMembers nvarchar(2),
	@#OfMembersNote nvarchar(max),
	@Term int,
	@TermLimit int,
	@TermLimitNote nvarchar(max),
	@AlternateMembers bit,
	@AssociateMembers bit,
	@CharterDate datetime=null,
	@Status nvarchar(10),
	@NewCommitteeID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @CommitteeID is not null begin
		UPDATE tblCommitteeData
		SET 
			CommitteeName=@CommitteeName,
			#OfMembers=@#OfMembers,
			#OfMembersNote=@#OfmembersNote,
			Term=@Term,
			TermLimit=@TermLimit,
			TermLimitNote=@TermLimitNote,
			AlternateMembers=@AlternateMembers,
			AssociateMembers=@AssociateMembers,
			CharterDate=@CharterDate,
			[Status]=@Status
		WHERE CommitteeID=@CommitteeID	
		SET @NewCommitteeID=@CommitteeID
	end else begin
		INSERT INTO tblCommitteeData (CommitteeName, #OfMembers, #OfMembersNote, Term, TermLimit, TermLimitNote, AlternateMembers, AssociateMembers, CharterDate, [Status])
		SELECT
			@CommitteeName, @#OfMembers, @#OfMembersNote, @Term, @TermLimit, @TermLimitNote, @AlternateMembers, @AssociateMembers, @CharterDate, @Status
		set @NewCommitteeID=scope_identity()
	end
END
GO
