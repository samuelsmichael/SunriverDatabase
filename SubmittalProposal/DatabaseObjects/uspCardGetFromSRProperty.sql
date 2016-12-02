USE SRPropertySQL

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 12/02/2016
-- Description:	Gets the data for ID Cards for "All Property Info"
/*
	exec uspCardGetFromSRProperty  @PropID='01001'
*/
-- =============================================
alter PROCEDURE uspCardGetFromSRProperty 
	@PropID nvarchar(10)	
AS
BEGIN
	select p.CardID,CustId,cdFirstName, cdLastName, cdClass, cdStatus, cdIssueDate
	FROM [ID-Card_Split_FE].[dbo].[luPropertyByCardholderName] p inner join 
		[ID-Card_Split_FE].[dbo].[tblInput-IDCard] c on c.CardID=p.CardID inner join
		[ID-Card_Split_FE].[dbo].[qryLotToOwnersLink] s on s.fkSRPropID=@PropID
	where p.fkISPropID=@PropID
	
END
GO
