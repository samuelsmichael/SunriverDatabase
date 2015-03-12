
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets all three of the main tables in the BPPermit part of the database
-- =============================================
ALTER PROCEDURE uspBPermitTablesGet 

AS
BEGIN
	SET NOCOUNT ON;
	select * from tblBPData
	select * from tblBPPayment
	select * from tblBPReviews
END
GO
