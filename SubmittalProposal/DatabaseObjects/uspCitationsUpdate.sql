SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/22/2016
-- Description:	Updates Citations
/*
	exec uspCitationsUpdate
*/
-- =============================================
alter PROCEDURE uspCitationsUpdate 
	@CitationID int=null,
	@VLastName nvarchar(20),
	@VFirstName nvarchar(20),
	@VMailAddr1 nvarchar(35),
	@VMailAddr2 nvarchar(35),
	@VCity nvarchar(20),
	@VState nvarchar(15),
	@VZip nvarchar(10),
	@VSunriverStatus nvarchar(20),
	@OffenseDate datetime=null,
	@OffenseLocation nvarchar(50),
	@CitingOfficer nvarchar(30),
	@HearingDate datetime=null,
	@MagistrateFine money = null,
	@JudicialFine money = null,
	@AssessedFine money = null,
	@WriteOff money = null,
	@FineBalToAcctg money = null,
	@FineStatus nvarchar(30),
	@MagistrateNotes nvarchar(max),
	@NewCitationID int out
AS
BEGIN
	SET NOCOUNT ON;
	if @CitationID is not null begin
		set @NewCitationID=@CitationID
		UPDATE [dbo].[tblCitations]
		   SET [VLastName] = @VLastName,
			  [VFirstName] = @VFirstName,
			  [VMailAddr1] = @VMailAddr1,
			  [VMailAddr2] = @VMailAddr2,
			  [VCity] = @VCity, 
			  [VState] = @VState, 
			  [VZip] = @VZip,
			  [VSunriverStatus] = @VSunriverStatus,
			  [OffenseDate] = @OffenseDate,
			  [OffenseLocation] = @OffenseLocation, 
			  [CitingOfficer] = @CitingOfficer,
			  [HearingDate] = @HearingDate,
			  [MagistrateFine] = @MagistrateFine,
			  [JudicialFine] = @JudicialFine,
			  [AssessedFine] = @AssessedFine, 
			  [WriteOff] = @WriteOff, 
			  [FineBalToAcctg] = @FineBalToAcctg,
			  [FineStatus] = @FineStatus, 
			  [MagistrateNotes] = @MagistrateNotes 
		 WHERE CitationID=@CitationID	
 end else begin
INSERT INTO [dbo].[tblCitations]
           ([VLastName]
           ,[VFirstName]
           ,[VMailAddr1]
           ,[VMailAddr2]
           ,[VCity]
           ,[VState]
           ,[VZip]
           ,[VSunriverStatus]
           ,[OffenseDate]
           ,[OffenseLocation]
           ,[CitingOfficer]
           ,[HearingDate]
           ,[MagistrateFine]
           ,[JudicialFine]
           ,[AssessedFine]
           ,[WriteOff]
           ,[FineBalToAcctg]
           ,[FineStatus]
           ,[MagistrateNotes])
     VALUES
           (@VLastName,
           @VFirstName,
           @VMailAddr1,
           @VMailAddr2, 
           @VCity,
           @VState,
           @VZip, 
           @VSunriverStatus,
           @OffenseDate, 
           @OffenseLocation, 
           @CitingOfficer,
           @HearingDate, 
           @MagistrateFine,
           @JudicialFine,
           @AssessedFine,
           @WriteOff,
           @FineBalToAcctg,
           @FineStatus, 
           @MagistrateNotes)
	set @NewCitationID=scope_identity()
	end
END
GO
