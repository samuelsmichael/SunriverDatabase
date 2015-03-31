SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/30/2015
-- Description:	Updates Submittal
/*
	exec uspSubmittalUpdate
*/
-- =============================================
ALTER PROCEDURE uspSubmittalUpdate 
	@SubmittalId int = null,
	@Own_Name nvarchar(40),
	@Lot nvarchar(5),
	@Lane nvarchar(28),
	@Applicant nvarchar(25),
	@Contractor nvarchar(30),
	@ProjectFee decimal(8,2)=null,
	@FeeDate datetime=null,
	@Mtg_Date datetime=null,
	@ProjectType nvarchar(3),
	@ProjectDecision nvarchar(3),
	@IsCommercial bit,
	@Project nvarchar(100),
	@Submittal nvarchar(max),
	@Conditions nvarchar(max),
	@NewSubmittalId int out
AS
BEGIN
	SET NOCOUNT ON;
	if(@SubmittalId is not null) begin
		set @NewSubmittalId=@SubmittalId
		update tblSubmittal
		set
			Own_Name=@Own_Name,
			Lot=@Lot,
			Lane=@Lane,
			Applicant=@Applicant,
			Contractor=@Contractor,
			ProjectFee = @ProjectFee,
			FeeDate=@FeeDate,
			Mtg_Date=@Mtg_Date,
			ProjectType=@Projecttype,
			ProjectDecision=@ProjectDecision,
			IsCommercial=@IsCommercial,
			Project=@Project,
			Submittal=@Submittal,
			Conditions=@Conditions
		where SubmittalId=@SubmittalId 
	end else begin
		INSERT INTO [dbo].[tblSubmittal]
           ([Own_Name]
           ,[Applicant]
           ,[Lot]
           ,[Lane]
           ,[Mtg_Date]
           ,[ProjectType]
           ,[Submittal]
           ,[Project]
           ,[ProjectDecision]
           ,[Conditions]
           ,[ProjectFee]
           ,[FeeDate]
           ,[Contractor]
           ,[IsCommercial])
		VALUES
           (@Own_Name
           ,@Applicant
           ,@Lot
           ,@Lane
           ,@Mtg_Date
           ,@ProjectType
           ,@Submittal
           ,@Project
           ,@ProjectDecision
           ,@Conditions
           ,@ProjectFee
           ,@FeeDate
           ,@Contractor
           ,@IsCommercial)
		set @NewSubmittalId=scope_identity()
	end
END
GO
