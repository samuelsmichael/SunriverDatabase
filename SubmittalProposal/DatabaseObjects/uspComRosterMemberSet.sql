USE ComRoster

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/26/2016
-- Description:	Updates the Member Data table
-- =============================================
alter PROCEDURE uspComRosterMemberSet 
	@MemberID int = null,
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@SRMailAddr1 nvarchar(30),
	@SRMailAddr2 nvarchar(30),
	@SRPhone nvarchar(20),
	@SRFax nvarchar(20),
	@Email nvarchar(50),
	@NRMailAddr nvarchar(max),
	@NRPhone nvarchar(20),
	@Comments nvarchar(max),
	@NewMemberID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @MemberID is not null begin
		UPDATE tblMemberData
		SET 
			FirstName=@FirstName,
			LastName=@LastName,
			SRMailAddr1=@SRMailAddr1,
			SRMailAddr2=@SRMailAddr2,
			SRPhone=@SRPhone,
			SRFax=@SRFax,
			Email=@Email,
			NRMailAddr=@NRMailAddr,
			NRPhone=@NRPhone,
			Comments=@Comments
		WHERE MemberID=@MemberID	
		SET @NewMemberID=@MemberID
	end else begin
		INSERT INTO tblMemberData (FirstName, LastName,SRMailAddr1,SRMailAddr2,SRPhone,SRFax,Email,NRMailAddr,NRPhone,Comments)
		SELECT
			@FirstName, @LastName,@SRMailAddr1,@SRMailAddr2,@SRPhone,@SRFax,@Email,@NRMailAddr,@NRPhone,@Comments
		set @NewMemberID=scope_identity()
	end
END
GO
