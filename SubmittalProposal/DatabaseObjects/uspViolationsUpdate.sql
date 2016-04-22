SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/22/2016
-- Description:	Updates Violations
/*
	exec uspViolationsUpdate
*/
-- =============================================
alter PROCEDURE uspViolationsUpdate 
	@ViolationID int=null,
	@fkCitationID int,
	@fkRuleID nvarchar(10),
	@ScheduleFine money=null,
	@IssueAsWarning bit,
	@ViolationNotes nvarchar(max),
	@ORSNumber nvarchar(8),
	@NewViolationID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @ViolationID is not null begin
		set @NewViolationID=@ViolationID
		UPDATE [dbo].[tblViolations]
		   SET [fkCitationID] = @fkCitationID,
			  [fkRuleID] = @fkRuleID,
			  [ScheduleFine] = @ScheduleFine,
			  [IssueAsWarning] = @IssueAsWarning,
			  [ViolationNotes] = @ViolationNotes, 
			  [ORS#] = @ORSNumber
		 WHERE ViolationID=@ViolationID	
 end else begin
INSERT INTO [dbo].[tblViolations]
           ([fkCitationID]
           ,[fkRuleID]
           ,[ScheduleFine]
           ,[IssueAsWarning]
           ,[ViolationNotes]
           ,[ORS#])
     VALUES
           (@fkCitationID
           ,@fkRuleID
           ,@ScheduleFine
           ,@IssueAsWarning
           ,@ViolationNotes
           ,@ORSNumber)
	set @NewViolationID=scope_identity()
	end
END
GO
