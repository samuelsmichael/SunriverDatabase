SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/9/2015
-- Description:	Computes Expires Date
/*
	select dbo.udfComputeExpires(4736)
*/
-- =============================================
ALTER FUNCTION udfComputeExpires 
(
	@BPermitId int
)
RETURNS DateTime
AS
BEGIN
	DECLARE @Result DateTime,
			@Months int

		SELECT 
			@Months=isnull(sum(isnull(BPMonths,0)),0)
		FROM 
			tblBPPayments
		WHERE fkBPermitID_PP=@BPermitId
		GROUP BY fkBPermitID_PP	

	select @Result=DATEADD(month,@Months,BPIssueDate) 
	from tblBPData
	where BPermitId=@BPermitId

	RETURN @Result

END
GO

