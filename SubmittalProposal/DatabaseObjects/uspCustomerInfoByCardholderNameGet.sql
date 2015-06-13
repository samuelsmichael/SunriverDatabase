-- ================================================
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
	select  isnull(c.cdLastName,'') + ' ' +  isnull(c.cdFirstName,'') as [Name], ll.SRLotLane, c.CardID, SRPropID+'|'+isnull(CustID,'') as PropIDBarCustId
	from 
		[tblinput-idcard] c inner join 
		[tblInput-SROA] s on c.fkISInputID=s.ISInputID inner join
		[tblArCust] a on s.fkISCustID=a.CustID inner join
		[tbllotlane_master] ll on s.fkISPropId=ll.SRPropId
	where not (isNumeric(cdLastName) = 1 and cdFirstName='card')
	Order by cdLastName, cdFirstName
end
GO
