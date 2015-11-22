SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Updates LRFD Service
/*
	exec uspLRFDServiceUpdate
*/
-- =============================================
create PROCEDURE uspLRFDServiceUpdate 
	@VWOCtrServID int = null,
	@fkVWOS_ID nvarchar(10),
	@CSDescription nvarchar(50)=null,
	@CSVendor nvarchar(20)=null,
	@CSCost money=null,
	@VWOCtrServIDOut int out
AS
BEGIN
	if(@VWOCtrServID is not null) begin
		set @VWOCtrServIDOut=@VWOCtrServID
		update tblVWOServices
		set
			CSDescription=@CSDescription,
			CSVendor=@CSVendor,
			CSCost=@CSCost
		where VWOCtrServID=@VWOCtrServID 
	end else begin
		INSERT INTO [dbo].tblVWOServices
           (fkVWOS_ID
           ,CSDescription
           ,CSVendor
		   ,CSCost)
		VALUES
           (@fkVWOS_ID
           ,@CSDescription
           ,@CSVendor
		   ,@CSCost)
		set @VWOCtrServIDOut=scope_identity()
	end
END
GO
