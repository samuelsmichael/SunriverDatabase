USE [Renewables]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/30/2018
-- Description:	Update Renewables
-- =============================================
alter PROCEDURE uspRenewablesUpdate (
	@renewID int = null,
	@BusinessName nvarchar (50),
	@ProjectName nvarchar(100),
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
			  -- other fields
		WHERE renewID=@renewID
 	end else begin
		INSERT INTO [dbo].[tblRenewables]
				   ([ProjectName]
				   ,[Business]
				   -- other fields
				)
			 VALUES
				   (@ProjectName
				   ,@BusinessName
				   -- other fields
				)
		set @renewIDOut=scope_identity()
	end

END
GO
