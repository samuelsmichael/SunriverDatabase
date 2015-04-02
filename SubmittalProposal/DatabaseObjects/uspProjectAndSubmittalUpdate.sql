SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/30/2015
-- Description:	Updates Submittal
/*
	exec uspProjectAndSubmittalUpdate
*/
-- =============================================
alter PROCEDURE uspProjectAndSubmittalUpdate 
	@SubmittalId int=null,
	@Own_Name nvarchar(40),
	@Lot nvarchar(5),
	@Lane nvarchar(28),
	@Applicant nvarchar(25),
	@Contractor nvarchar(30),
	@ProjectType nvarchar(3),
	@Project nvarchar(100),
	@BPermitId int = null,
	@BPermitReqd bit,
	@BPIssueDate datetime=null,
	@BPClosed datetime=null,
	@BPDelay nvarchar(255),
	@NewBPermitID int out,
	@NewSubmittalID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @SubmittalId is not null begin
		set @NewSubmittalId=@SubmittalId
		update tblSubmittal
		set
			Own_Name=@Own_Name,
			Lot=@Lot,
			Lane=@Lane,
			Applicant=@Applicant,
			Contractor=@Contractor,
			Project=@Project,
			ProjectType=@ProjectType
		where SubmittalId=@SubmittalId 
	end else begin
		INSERT INTO [dbo].[tblSubmittal]
           ([Own_Name]
           ,[Applicant]
           ,[Lot]
           ,[Lane]
           ,[ProjectType]
           ,[Project]
           ,[Contractor])
		VALUES
           (@Own_Name
           ,@Applicant
           ,@Lot
           ,@Lane
           ,@ProjectType
           ,@Project
           ,@Contractor)
		set @NewSubmittalId=scope_identity()
	end
	if @BPermitId is not null begin
		set @NewBPermitID=@BPermitReqd
		update tblBPData
		SET
			BPermitReqd=@BPermitReqd,
			BPIssueDate=@BPIssueDate,
			BPClosed=@BPClosed,
			BPDelay=@BPDelay
		WHERE BPermitID = @BPermitId
	end else begin
		INSERT INTO [dbo].[tblBPData]
           (
		    [fkSubmittalID_PD]
           ,[BPermitReqd]
           ,[BPIssueDate]
           ,[BPClosed]
           ,[BPDelay])
		VALUES
           (
		    @SubmittalId
           ,@BPermitReqd
           ,@BPIssueDate
           ,@BPClosed
           ,@BPDelay
		   )
		set @NewBPermitID=scope_identity()
	end
END
GO
