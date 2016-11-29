USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspSROALaborUpdate]    Script Date: 11/27/2016 3:44:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Updates Labor
/*
	exec uspSROALaborUpdate
*/
-- =============================================
create PROCEDURE [dbo].[uspSROALaborUpdate] 
	@VWOLaborID int = null,
	@fkVWOL_ID nvarchar(10),
	@MechName nvarchar(25)=null,
	@MechHours real=null,
	@MechRate money=null,
	@VWOLaborIDOut int out
AS
BEGIN
	if(@VWOLaborID is not null) begin
		set @VWOLaborIDOut=@VWOLaborID
		update tblVWOLabor
		set
			MechName=@MechName,
			MechHours=@MechHours,
			MechRate=@MechRate
		where VWOLaborID=@VWOLaborID 
	end else begin
		INSERT INTO [dbo].tblVWOLabor
           (fkVWOL_ID
           ,MechName
           ,MechHours
		   ,MechRate)
		VALUES
           (@fkVWOL_ID
           ,@MechName
           ,@MechHours
		   ,@MechRate)
		set @VWOLaborIDOut=scope_identity()
	end
END

