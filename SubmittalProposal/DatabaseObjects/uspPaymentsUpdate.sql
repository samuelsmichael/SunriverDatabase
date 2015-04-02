SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/01/2015
-- Description:	Updates Payments
/*
	exec uspPaymentsUpdate
*/
-- =============================================
alter PROCEDURE uspPaymentsUpdate 
	@BPPaymentId int = null,
	@BPermitId int = null,
	@BPMonths int=null,
	@BPFee money=null,
	@NewBPPaymentID int out
AS
BEGIN
	declare @newPmtNbr int
	SET NOCOUNT ON;
	if(@BPPaymentId is not null) begin
		set @NewBPPaymentID=@BPPaymentId
		update tblBPPayments
		set
			BPMonths=@BPMonths,
			BPFee$=@BPFee
		where BPPaymentId=@BPPaymentId 
	end else begin
		set @newPmtNbr=((select count(*) from tblBPPayments where fkBPermitID_PP=@BPermitId)+1)
		INSERT INTO [dbo].tblBPPayments
           ([fkBPermitID_PP]
           ,[BPMonths]
           ,[BPFee$]
		   ,BPPmt)
		VALUES
           (@BPermitId
           ,@BPMonths
           ,@BPFee
		   ,@newPmtNbr)
		set @NewBPPaymentID=scope_identity()
	end
END
GO
