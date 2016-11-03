USE ComRoster	

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/26/2016
-- Description:	Updates the Liaison Data table
	/*
		declare @NewLiaisonID int
		exec uspComRosterLiaisonSet
			@LiaisonID = 59,
			@LiaisonName = 'Hugh Palcic',
			@LiaisonType ='SROA Staff',
			@LiaisonSRMail1 = 'PO Box 3278',
			@LiaisonSRMail2 = null,
			@LiaisonEmail ='hughp@srowners.org',
			@LiaisonSRPhone ='5932411',
			@LiaisonRepresents ='General Manager',
			@LiaisonNRMail = null,
			@LiaisonNRPhone = null,
			@HonorLiaisonIDRestrictions =1 ,
			@NewLiaisonID=@NewLiaisonID out
		print '@NewLiaisonID='
		print cast(@NewLiaisonID as varchar)
*/  -----update tblLiaisonData set LiaisonType='associate' where liaisonid=60
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
	@HonorLiaisonIDRestrictions bit,
	@NewLiaisonID int out
AS
BEGIN
	SET NOCOUNT ON;
	Declare 
		@OriginalLiaisonType nvarchar(15),
		@LiaisonIDTakingIntoConsiderationRestrictions int
	set @LiaisonIDTakingIntoConsiderationRestrictions=@LiaisonID
	IF @HonorLiaisonIDRestrictions=1 begin
		if @LiaisonID is not null begin
			select @OriginalLiaisonType=LiaisonType FROM tblLiaisonData where LiaisonID=@LiaisonID
		end else begin
			set @OriginalLiaisonType = null
		end
		print '@LiaisonID'
		print cast (@LiaisonID as varchar)
		print 'OriginalLiaisonType'
		print @OriginalLiaisonType
		print '@LiaisonType'
		print @LiaisonType
		exec uspFindLegitmateLiaisonID
			@OrignalLiaisonID = @LiaisonID,
			@OriginalLiaisonType = @OriginalLiaisonType,
			@NewLiaisonType = @LiaisonType,
			@NewLiaisonID =  @LiaisonIDTakingIntoConsiderationRestrictions out
		print '@LiaisonIDTakingIntoConsiderationRestrictions='
		print cast(@LiaisonIDTakingIntoConsiderationRestrictions as varchar)
	end
	if @LiaisonID is not null begin
		if @LiaisonIDTakingIntoConsiderationRestrictions!=@LiaisonID  begin			
			delete from tblliaisonData where LiaisonID=@LiaisonID
			delete from tblliaisonData where LiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
			INSERT INTO tblLiaisonData (LiaisonID, LiaisonName, LiaisonType,LiaisonSRMail1,LiaisonSRMail2,LiaisonSRPhone,LiaisonRepresents,LiaisonNRMail,LiaisonNRPhone, LiaisonEmail)
			SELECT
				@LiaisonIDTakingIntoConsiderationRestrictions, @LiaisonName, @LiaisonType,@LiaisonSRMail1,@LiaisonSRMail2,@LiaisonSRPhone,@LiaisonRepresents,@LiaisonNRMail,@LiaisonNRPhone,@LiaisonEmail
			set @NewLiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
		end else begin
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
				LiaisonNRPhone=@LiaisonNRPhone,
				LiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
			WHERE LiaisonID=@LiaisonID	
			SET @NewLiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
		end
		if @LiaisonIDTakingIntoConsiderationRestrictions != @LiaisonID begin
			update tblRosterLiaison
			set LiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
			where LiaisonID=@LiaisonID 
			set @LiaisonID=@LiaisonID
		end 
	end else begin
		if exists (select * from tblLiaisonData where LiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions) begin
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
				LiaisonNRPhone=@LiaisonNRPhone,
				LiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
			WHERE LiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions	
		end else begin
			INSERT INTO tblLiaisonData (LiaisonID, LiaisonName, LiaisonType,LiaisonSRMail1,LiaisonSRMail2,LiaisonSRPhone,LiaisonRepresents,LiaisonNRMail,LiaisonNRPhone, LiaisonEmail)
			SELECT
				@LiaisonIDTakingIntoConsiderationRestrictions, @LiaisonName, @LiaisonType,@LiaisonSRMail1,@LiaisonSRMail2,@LiaisonSRPhone,@LiaisonRepresents,@LiaisonNRMail,@LiaisonNRPhone,@LiaisonEmail
		end
		set @NewLiaisonID=@LiaisonIDTakingIntoConsiderationRestrictions
	end
END
GO
