SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates Parts
/*
	exec uspLRFDVehicleMaintenanceUpdate
*/
-- =============================================
create PROCEDURE uspLRFDVehicleMaintenanceUpdate 
    @VWOID nvarchar(10) = null,
    @fkNumber nvarchar(12),
    @Estimate bit =null,
    @RequestBy nvarchar(20) =null,
    @RequestNature  nvarchar(max) =null,
    @DateIn datetime = null,
    @DateOut datetime = null,
    @DataEntryDate datetime = null,
    @DataEntryBy nvarchar(20) = null,
    @Odometer  real = null,
    @HourMeter real = null,
    @Proceedure1 nvarchar(max) = null,
    @Comments nvarchar(max) = null,
    @AdminRate real = null,
	@VWOID_new nvarchar(10) = null
AS
BEGIN
	SET NOCOUNT ON;
	if(@VWOID is not null) begin
		update tblVWOData
	    SET [VWOID] = @VWOID
		  ,[fkNumber] = @fkNumber
		  ,[Estimate] = @Estimate
		  ,[Request By] = @RequestBy
		  ,[Request Nature] = @RequestNature
		  ,[Date In] = @DateIn
		  ,[Date Out] = @DateOut
		  ,[Data Entry Date] = @DataEntryDate
		  ,[Data Entry By] = @DataEntryBy
		  ,[Odometer] = @Odometer
		  ,[Hour Meter] = @HourMeter
		  ,[Proceedure 1] = @Proceedure1
		  ,[Comments] = @Comments
		  ,[AdminRate] = @AdminRate
		where VWOID=@VWOID 
	end else begin
		INSERT INTO [dbo].[tblVWOData]
				   ([VWOID]
				   ,[fkNumber]
				   ,[Estimate]
				   ,[Request By]
				   ,[Request Nature]
				   ,[Date In]
				   ,[Date Out]
				   ,[Data Entry Date]
				   ,[Data Entry By]
				   ,[Odometer]
				   ,[Hour Meter]
				   ,[Proceedure 1]
				   ,[Comments]
				   ,[AdminRate])
			 VALUES
				   (@VWOID_new
				   ,@fkNumber
				   ,@Estimate
				   ,@RequestBy
				   ,@RequestNature
				   ,@DateIn
				   ,@DateOut
				   ,@DataEntryDate
				   ,@DataEntryBy
				   ,@Odometer
				   ,@HourMeter
				   ,@Proceedure1
				   ,@Comments
				   ,@AdminRate)
		end
END
GO
