-- ================================================
USE [ID-Card_Split_FE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the Customer info
-- =============================================
alter PROCEDURE uspCustomerInfoByCardholderNameGet
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
		p.fkISPropID + '|' + o.CustID as propIdBarCustId,
		p.[Name], p.[ISAddress] as SRLotLane
	FROM [luPropertyByCardholderName] p INNER JOIN
		 qryLotToOwnersLink o ON o.fkSRPropID=p.fkISPropID
	ORDER BY [Name]
end

GO
