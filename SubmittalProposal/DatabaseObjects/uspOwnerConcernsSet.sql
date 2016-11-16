USE [OwnerConcerns]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/15/2016
-- Description:	Updates OnwerConcern
/*
	exec uspOwnerConcernsSet
*/
-- =============================================
alter PROCEDURE uspOwnerConcernsSet 
	@OCCase# int = null
	,@SubmitDate datetime=null
	,@FirstName nvarchar(20)
	,@LastName nvarchar(20)
	,@OwnerID# nvarchar(10)=null
	,@OwnerPhone# nvarchar(20)
	,@DeptReferred1 nvarchar(30)
	,@DeptReferred2 nvarchar(30)
	,@Category nvarchar(30)
	,@PubWksWO# int = null
    ,@Description nvarchar(max)
	,@Resolution nvarchar(max)
	,@ResolutionDate datetime=null
	,@StartFormBy nvarchar(25)
	,@CloseFormBy  nvarchar(25)
	,@ApprovedBy  nvarchar(25)
	,@NotifyDate  datetime = null
	,@NotifiedBy nvarchar(20)
	,@SRAddress nvarchar(25)
	,@EmailAddr nvarchar(30)
	,@NewOCCase# int out
AS
BEGIN
	SET NOCOUNT ON;

	if @OCCase# is not null begin

		UPDATE [dbo].[tblOCData]
		   SET [SubmitDate] = @SubmitDate
			  ,[FirstName] = @FirstName
			  ,[LastName] = @LastName
			  ,[OwnerID#] = @OwnerID#
			  ,[OwnerPhone#] = @OwnerPhone#
			  ,[DeptReferred1] = @DeptReferred1
			  ,[DeptReferred2] = @DeptReferred2
			  ,[Category] = @Category
			  ,[PubWksWO#] = @PubWksWO#
			  ,[Description] = @Description
			  ,[Resolution] = @Resolution
			  ,[ResolutionDate] = @ResolutionDate
			  ,[StartFormBy] = @StartFormBy
			  ,[CloseFormBy] = @CloseFormBy
			  ,[ApprovedBy] = @ApprovedBy
			  ,[NotifyDate] = @NotifyDate
			  ,[NotifiedBy] = @NotifiedBy
			  ,[SRAddress] = @SRAddress
			  ,[EmailAddr] = @EmailAddr
		 WHERE [OCCase#]=@OCCase#
		 SET @NewOCCase#=@OCCase#
	end else begin
		INSERT INTO [dbo].[tblOCData]
				   ([SubmitDate]
				   ,[FirstName]
				   ,[LastName]
				   ,[OwnerID#]
				   ,[OwnerPhone#]
				   ,[DeptReferred1]
				   ,[DeptReferred2]
				   ,[Category]
				   ,[PubWksWO#]
				   ,[Description]
				   ,[Resolution]
				   ,[ResolutionDate]
				   ,[StartFormBy]
				   ,[CloseFormBy]
				   ,[ApprovedBy]
				   ,[NotifyDate]
				   ,[NotifiedBy]
				   ,[SRAddress]
				   ,[EmailAddr])
			 VALUES (
					@SubmitDate
				   ,@FirstName
				   ,@LastName
				   ,@OwnerID#
				   ,@OwnerPhone#
				   ,@DeptReferred1
				   ,@DeptReferred2
				   ,@Category
				   ,@PubWksWO#
				   ,@Description
				   ,@Resolution
				   ,@ResolutionDate
				   ,@StartFormBy
				   ,@CloseFormBy
				   ,@ApprovedBy
				   ,@NotifyDate
				   ,@NotifiedBy
				   ,@SRAddress
				   ,@EmailAddr
			)
		set @NewOCCase#=scope_identity()
	end
		
END
GO
