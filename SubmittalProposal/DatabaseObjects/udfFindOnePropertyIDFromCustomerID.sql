SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/21/2015
-- Description:	Find one Property ID from CustomerID
/*
	select  dbo.udfFindOnePropertyIDFromCustomerID('081430')
*/
-- =============================================
alter FUNCTION udfFindOnePropertyIDFromCustomerID 
(
	@CustomerID nvarchar(10)
)
RETURNS nvarchar(10)
AS
BEGIN
	declare @retValue nvarchar(10)
	SELECT TOP 1 @retValue=srPropId FROM [ID-Card_Split_FE].[dbo].[qryLotLaneWithOwners_Master] WHERE CustId=@CustomerID
	RETURN @retValue

END
GO

