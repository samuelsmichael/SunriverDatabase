SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Gets the tables of Citations
-- exec uspBallotVerifyInitialize
-- =============================================
alter PROCEDURE uspBallotVerifyInitialize 
AS
BEGIN
	truncate table tblBallotVerify
	INSERT INTO [dbo].[tblBallotVerify]
	SELECT GroupCode,CustId,PropId,Addr1,Voted,PostalCode,OwnerName,Contact,CustAddr1,CustAddr2
	FROM 
		qrytblBallotVerify_MakeNew

END

