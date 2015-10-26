SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Get Client Info 
/*
	declare @cus nvarchar(20)
	set @cus='002900'
	exec UspClientInfoGet @ClientID=@cus
*/
-- =============================================
alter PROCEDURE uspClientInfoGet 
	@ClientID nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	declare @qry varchar(200)
	set @qry = 'SELECT *  FROM [ID-Card_Split_FE].[dbo].[qryLotLaneWithOwners_Master] WHERE CustId=''' + @ClientID  + '''';
	exec(@qry)
END
GO
