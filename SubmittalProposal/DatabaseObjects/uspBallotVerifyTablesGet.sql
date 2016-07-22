SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 7/07/2015
-- Description:	Gets the tables of Ballot Verify
-- exec uspBallotVerifyTablesGet
/*
	select * from tblBallotVerify where tblArshipTo_Addr1!=tblArCust_Addr1
*/
-- =============================================
create PROCEDURE uspBallotVerifyTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select * FROM tblBallotVerify 
END
GO
