SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates Parts
/*
	exec uspLRFDPartsUpdate
*/
-- =============================================
alter PROCEDURE uspLRFDPartsUpdate 
	@VWOPartID int = null,
	@fkVWOP_ID nvarchar(10),
	@ptDescription nvarchar(30)=null,
	@ptNumber nvarchar(15)=null,
	@ptRate money=null,
	@ptQuan real=null,
	@NewVWOPartID int out
AS
BEGIN
	DECLARE @PartMarkUpRate real
	SET NOCOUNT ON;
	SELECT @PartMarkUpRate=PartMarkUpRate from [tblDepartment{LU}] where DepartmentID = (SELECT fkDeptID from [tblVehicleList{LU}] where Number = (SELECT fkNumber FROM tblVWOData WHERE VWOID=@fkVWOP_ID))
	if(@VWOPartID is not null) begin
		set @NewVWOPartID=@VWOPartID
		update tblVWOParts
		set
			PtDescription=@ptDescription,
			PtNumber=@ptNumber,
			PtRate=@ptRate,
			PtQuan=@ptQuan,
			PtMkUpRate = @PartMarkUpRate
		where VWOPartID=@VWOPartID 
	end else begin
		INSERT INTO [dbo].tblVWOParts
           ([fkVWOP_Id]
           ,[PtDescription]
           ,[PtNumber]
		   ,[PtRate]
		   ,[PtQuan]
		   ,PtMkUpRate)
		VALUES
           (@fkVWOP_ID
           ,@ptDescription
           ,@ptNumber
		   ,@ptRate
		   ,@PtQuan
		   ,@PartMarkUpRate)
		set @NewVWOPartID=scope_identity()
	end
END
GO
