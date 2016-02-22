-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Updates a Card record
/*
	exec uspCardGet @PropId='87462'
*/
-- =============================================
alter PROCEDURE uspCardPut (
	@CardId int = null,
	@fkISInputID int = null,
	@FirstName nvarchar(20) = null,
	@LastName nvarchar(20) = null,
	@Class nvarchar(20)=null,
	@DOB datetime=null,
	@Status nvarchar(15)=null,
	@IssueDate datetime=null,
	@FeePaid money=null,
	@IDCardIssued nvarchar(3)=null,
	@RecPassIssued nvarchar(3)=null,
	@Comments ntext=null,
	@Photo1 nvarchar(80)=null,
	@ISAddress nvarchar(50)=null,
	@ISSort nvarchar(50)=null,
	@fkISPropID nvarchar(50)=null,
	@RenewalDate datetime=null,
	@ExpirationDate datetime=null,
	@PermanentNote nvarchar(30)=null,
	@NewCardId int out
)
AS
BEGIN
	SET NOCOUNT ON;
	if @CardId is not null begin
		set @NewCardId=@CardId
		UPDATE [dbo].[tblInput-IDCard]
		   SET [cdFirstName] = @FirstName
			  ,[cdLastName] = @LastName
			  ,[cdDOB] = @DOB
			  ,[cdClass] = @Class
			  ,[cdStatus] = @Status
			  ,[cdIssueDate] = @IssueDate
			  ,[cdComments] = @Comments
			  ,[cdFeePaid] = @FeePaid
			  ,[cdIDCardIssued] = @IDCardIssued
			  ,[cdRecPassIssued] = @RecPassIssued
			  ,[cdPermanentNote]=@PermanentNote
		 WHERE CardID=@CardId
	end else 
	begin
		INSERT INTO [dbo].[tblInput-IDCard]
				   ([fkISInputID]
				   ,[cdFirstName]
				   ,[cdLastName]
				   ,[cdDOB]
				   ,[cdClass]
				   ,[cdStatus]
				   ,[cdIssueDate]
				   ,[cdComments]
				   ,[cdPhoto1]
				   ,[cdFeePaid]
				   ,[cdIDCardIssued]
				   ,[cdRecPassIssued]
				   ,[ISAddress]
				   ,[ISSort]
				   ,[fkISPropID]
				   ,[cdRenewalDate]
				   ,[cdExpirationDate]
				   ,[cdPermanentNote])
			 VALUES
				   (@fkISInputID
				   ,@FirstName
				   ,@LastName
				   ,@DOB
				   ,@Class
				   ,@Status
				   ,@IssueDate
				   ,@Comments
				   ,@Photo1
				   ,@FeePaid
				   ,@IdCardIssued
				   ,@RecPassIssued
				   ,@IsAddress
				   ,@IsSort
				   ,@fkISPropID
				   ,@RenewalDate
				   ,@ExpirationDate
				   ,@PermanentNote)
		set @NewCardId=scope_identity()
	end
end
GO
