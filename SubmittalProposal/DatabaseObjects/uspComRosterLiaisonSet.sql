USE ComRoster

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/26/2016
-- Description:	Updates the Liaison Data table
-- =============================================
alter PROCEDURE uspComRosterLiaisonSet 
	@LiaisonID int = null,
	@LiaisonName nvarchar(30),
	@LiaisonType nvarchar(15),
	@LiaisonSRMail1 nvarchar(30),
	@LiaisonSRMail2 nvarchar(30),
	@LiaisonEmail nvarchar(30),
	@LiaisonSRPhone nvarchar(20),
	@LiaisonRepresents nvarchar(20),
	@LiaisonNRMail nvarchar(max),
	@LiaisonNRPhone nvarchar(20),
	@NewLiaisonID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @LiaisonID is not null begin
		UPDATE tblLiaisonData
		SET 
			LiaisonName=@LiaisonName,
			LiaisonType=@LiaisonType,
			LiaisonSRMail1=@LiaisonSRMail1,
			LiaisonSRMail2=@LiaisonSRMail2,
			LiaisonEmail=@LiaisonEmail,
			LiaisonSRPhone=@LiaisonSRPhone,
			LiaisonRepresents=@LiaisonRepresents,
			LiaisonNRMail=@LiaisonNRMail,
			LiaisonNRPhone=@LiaisonNRPhone
		WHERE LiaisonID=@LiaisonID	
		SET @NewLiaisonID=@LiaisonID
	end else begin
		INSERT INTO tblLiaisonData (LiaisonName, LiaisonType,LiaisonSRMail1,LiaisonSRMail2,LiaisonSRPhone,LiaisonRepresents,LiaisonNRMail,LiaisonNRPhone, LiaisonEmail)
		SELECT
			@LiaisonName, @LiaisonType,@LiaisonSRMail1,@LiaisonSRMail2,@LiaisonSRPhone,@LiaisonRepresents,@LiaisonNRMail,@LiaisonNRPhone,@LiaisonEmail
		set @NewLiaisonID=scope_identity()
	end
END
GO
