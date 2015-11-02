SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/2/2015
-- Description: Updates all non-cancelled leases' paid to NO
-- =============================================
/*
	exec [uspUpdateAllNon-CancelledLeasesToPaidNO]
*/
alter PROCEDURE [uspUpdateAllNon-CancelledLeasesToPaidNO]
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE tblRVData SET LeasePaid = 0
	WHERE LeaseCancelled=0 and LeaseCancelled!=0
END
GO
