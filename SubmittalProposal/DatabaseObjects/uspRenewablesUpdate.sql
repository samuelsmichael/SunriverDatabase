USE [Renewables]
GO
/****** Object:  StoredProcedure [dbo].[uspRenewablesUpdate]    Script Date: 3/21/2019 3:39:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/30/2018
-- Description:	Update Renewables
-- =============================================
ALTER PROCEDURE [dbo].[uspRenewablesUpdate] (
	@renewID int = null,
	@ProjectName nvarchar(100),
	@BusinessName nvarchar (50),
	@BusinessAddress nvarchar(100),
	@BusinessPhone nvarchar(50),
	@BusinessContactName nvarchar(50),
	@TermofRenewable nvarchar(50),
	@RenewableReviewDate datetime = null,
	@RenewableStartDate datetime =null,
	@RenewableEndDate datetime =null,
	@RenewableTermDate datetime =null,
	@AutoRenewal bit = null,
	@TermCost nvarchar(50),
	@PaymentType nvarchar(50),
	@SROADepartment nvarchar(50),
	@Notes nvarchar(max),
	@RenewableType nvarchar(50),
	@renewIDOut int out
)
AS
BEGIN
	SET NOCOUNT ON;
	if(@renewID is not null) begin
		set @renewIDOut=@renewID
		UPDATE [dbo].[tblRenewables]
		   SET [Business] = @BusinessName
			  ,[ProjectName] = @ProjectName
			  ,BusinessAddress=@BusinessAddress
			,BusinessPhone =@BusinessPhone
			,BusinessContactName =@BusinessContactName
			,TermofRenewable=@TermOfRenewable
			,RenewableReviewDate = @RenewableReviewDate
			,RenewableStartDate = @RenewableStartDate
			,RenewableEndDate =@RenewableEndDate
			,RenewableTermDate =@RenewableTermDate
			,AutoRenewal =@AutoRenewal
			,TermCost =@TermCost
			,PaymentType =@PaymentType
			,SROADepartment =@SROADepartment
			,Notes =@Notes
			,RenewableType = @RenewableType

			  -- other fields
		WHERE renewID=@renewID
 	end else begin
		INSERT INTO [dbo].[tblRenewables]
				   ([ProjectName]
				   ,[Business]
				   ,BusinessAddress
				   ,BusinessPhone
					,BusinessContactName
					,TermofRenewable
					,RenewableReviewDate
					,RenewableStartDate
					,RenewableEndDate
					,RenewableTermDate
					,AutoRenewal
					,TermCost
					,PaymentType
					,SROADepartment
					,Notes
					,RenewableType
				)
			 VALUES
				   (@ProjectName
				   ,@BusinessName
					,@BusinessAddress
					,@BusinessPhone
					,@BusinessContactName
					,@TermOfRenewable
					,@RenewableReviewDate
					,@RenewableStartDate
					,@RenewableEndDate
					,@RenewableTermDate
					,@AutoRenewal
					,@TermCost
					,@PaymentType
					,@SROADepartment
					,@Notes
					,@RenewableType
				)
		set @renewIDOut=scope_identity()
	end

END
