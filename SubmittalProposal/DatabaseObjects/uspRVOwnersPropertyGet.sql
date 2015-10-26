SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Get Client Info  
-- =============================================
ALTER PROCEDURE uspClentInfoGet {
	@ClientID nvarchar(1)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT * FROM  FROM [ID-Card_Split_FE].[dbo].[qryLotLaneWithOwners_Master] WHERE CustId=@ClientID;
END
GO
