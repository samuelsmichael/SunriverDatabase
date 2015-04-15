SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/14/2015
-- Description:	Derive BPStatus
-- =============================================
CREATE FUNCTION udfComputeBPStatus (@BPPermitID int)

RETURNS varchar(7)
AS
BEGIN
	DECLARE @Result varchar(7)
	SELECT @Result = CASE WHEN ISDATE(BPClosed)=1 THEN 'CLOSED' ELSE CASE WHEN BPExpires<getdate() THEN 'EXPIRED' ELSE 'VALID' END END
	FROM tblBPData
	WHERE BPermitID=@BPPermitID

	RETURN @Result

END
GO

