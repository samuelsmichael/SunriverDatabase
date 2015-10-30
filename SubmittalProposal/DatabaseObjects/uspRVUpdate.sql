SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Update RVData 
-- =============================================
alter PROCEDURE uspRVUpdate 
	@RVLeaseID int=null,
    @CustomerID nvarchar(10),
    @FirstName nvarchar(25),
    @LastName nvarchar(25),
    @NO_MailAddr1 nvarchar(30),
    @NO_MailAddr2 nvarchar(30),
    @NO_City nvarchar(25),
    @NO_State nvarchar(10),
    @NO_Zip nvarchar(10),
    @NO_SunriverAddr nvarchar(30),
    @SunriverPhone nvarchar(18),
    @OtherPhone nvarchar(20),
    @E_Mail nvarchar(30),
    @DrivLics# nvarchar(20),
    @DrivLicsState nvarchar(3),
    @RVType nvarchar(25),
    @RVMake nvarchar(25),
    @RVModel nvarchar(25),
    @VehLics# nvarchar(15),
    @VehLicsState nvarchar(3),
    @VehicleLength nvarchar(10),
    @SpaceSizeReqt nvarchar(10),
    @ElectricReqt bit,
    @Lien nvarchar(30),
    @tRVDSpace nvarchar(10),
    @SpaceType nvarchar(10),
    @PermanantAssign bit,
    @LeasePaid bit,
    @Notes nvarchar(max),
    @WaitListDate datetime=null,
    @LeaseStartDate datetime=null,
    @LeaseCancelDate datetime=null,
    @LeaseCancelled bit,
    --@WarningFlag1 nvarchar(18),
    --@Credit$ real,
    --@CreditPaid bit,
    --@FinalRent real,
    @PropOwnerName nvarchar(30),
    @PropOwnerID nvarchar(10),
	@NewscLeaseID int out
AS
BEGIN
	if @RVLeaseID is not null begin
			UPDATE [dbo].[tblRVData]
		   SET 
			  [CustomerID] = @CustomerID
			  ,[FirstName] = @FirstName
			  ,[LastName] = @LastName
			  ,[NO-MailAddr1] = @NO_MailAddr1
			  ,[NO-MailAddr2] = @NO_MailAddr2
			  ,[NO-City] = @NO_City
			  ,[NO-State] = @NO_State
			  ,[NO-Zip] = @NO_Zip
			  ,[NO-SunriverAddr] = @NO_SunriverAddr
			  ,[SunriverPhone] = @SunriverPhone
			  ,[OtherPhone] = @OtherPhone
			  ,[E-Mail] = @E_Mail
			  ,[DrivLics#] = @DrivLics#
			  ,[DrivLicsState] = @DrivLicsState
			  ,[RVType] = @RVType
			  ,[RVMake] = @RVMake
			  ,[RVModel] = @RVModel
			  ,[VehLics#] = @VehLics#
			  ,[VehLicsState] = @VehLicsState
			  ,[VehicleLength] = @VehicleLength
			  ,[SpaceSizeReqt] = @SpaceSizeReqt
			  ,[ElectricReqt] = @ElectricReqt
			  ,[Lien] = @Lien
			  ,[tRVDSpace] = @tRVDSpace
			  ,[SpaceType] = @SpaceType
			  ,[PermanantAssign] = @PermanantAssign
			  ,[LeasePaid] = @LeasePaid
			  ,[Notes] = @Notes
			  ,[WaitListDate] = @WaitListDate
			  ,[LeaseStartDate] = @LeaseStartDate
			  ,[LeaseCancelDate] = @LeaseCancelDate
			  ,[LeaseCancelled] = @LeaseCancelled
			  --,[WarningFlag1] = @WarningFlag1
			  --,[Credit$] = @Credit$
			  --,[CreditPaid] = @CreditPaid
			  --,[FinalRent] = @FinalRent
			  ,[PropOwnerName] = @PropOwnerName
			  ,[PropOwnerID] = @PropOwnerID
		 WHERE RVLeaseID=@RVLeaseID
		 if @LeaseCancelled=0 begin
			Update [tblSpaceInfo{LU}] set SpaceLeased = 1 WHERE tSISpace=@tRVDSpace
		 end else begin
			if not exists ( select RVLeaseID from tblRVData
							where RVLeaseID != @RVLeaseID and LeaseCancelled=0) begin
				Update [tblSpaceInfo{LU}] set SpaceLeased = 0 WHERE tSISpace=@tRVDSpace
			end
		 end
		 set @NewscLeaseID=@RVLeaseID
	end	else begin
		INSERT INTO [dbo].[tblRVData]
				   ([CustomerID]
				   ,[FirstName]
				   ,[LastName]
				   ,[NO-MailAddr1]
				   ,[NO-MailAddr2]
				   ,[NO-City]
				   ,[NO-State]
				   ,[NO-Zip]
				   ,[NO-SunriverAddr]
				   ,[SunriverPhone]
				   ,[OtherPhone]
				   ,[E-Mail]
				   ,[DrivLics#]
				   ,[DrivLicsState]
				   ,[RVType]
				   ,[RVMake]
				   ,[RVModel]
				   ,[VehLics#]
				   ,[VehLicsState]
				   ,[VehicleLength]
				   ,[SpaceSizeReqt]
				   ,[ElectricReqt]
				   ,[Lien]
				   ,[tRVDSpace]
				   ,[SpaceType]
				   ,[PermanantAssign]
				   ,[LeasePaid]
				   ,[Notes]
				   ,[WaitListDate]
				   ,[LeaseStartDate]
				   ,[LeaseCancelDate]
				   ,[LeaseCancelled]
				   ,[WarningFlag1]
				   ,[Credit$]
				   ,[CreditPaid]
				   ,[FinalRent]
				   ,[PropOwnerName]
				   ,[PropOwnerID])
			 VALUES (
				   @CustomerID
				   ,@FirstName
				   ,@LastName
				   ,@NO_MailAddr1
				   ,@NO_MailAddr2
				   ,@NO_City
				   ,@NO_State 
				   ,@NO_Zip
				   ,@NO_SunriverAddr
				   ,@SunriverPhone
				   ,@OtherPhone
				   ,@E_Mail
				   ,@DrivLics#
				   ,@DrivLicsState
				   ,@RVType
				   ,@RVMake
				   ,@RVModel
				   ,@VehLics#
				   ,@VehLicsState
				   ,@VehicleLength
				   ,@SpaceSizeReqt
				   ,@ElectricReqt
				   ,@Lien
				   ,@tRVDSpace
				   ,@SpaceType
				   ,@PermanantAssign
				   ,@LeasePaid
				   ,@Notes
				   ,@WaitListDate
				   ,@LeaseStartDate
				   ,@LeaseCancelDate
				   ,@LeaseCancelled
				   ,null
				   ,null
				   ,0
				   ,null
				   ,@PropOwnerName
				   ,@PropOwnerID)
			set @NewscLeaseID=scope_identity()
		 if @LeaseCancelled=0 begin
			Update [tblSpaceInfo{LU}] set SpaceLeased = 1 WHERE tSISpace=@tRVDSpace
		 end else begin
			if not exists ( select RVLeaseID from tblRVData
							where RVLeaseID != @RVLeaseID and LeaseCancelled=0) begin
				Update [tblSpaceInfo{LU}] set SpaceLeased = 0 WHERE tSISpace=@tRVDSpace
			end
		 end
	end
END
GO
