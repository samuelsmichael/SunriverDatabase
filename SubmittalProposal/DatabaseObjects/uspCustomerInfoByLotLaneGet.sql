-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the data to populate the Find by Lot Number dropdown
-- =============================================
alter PROCEDURE uspCustomerInfoByLotLaneGet
AS
BEGIN
	SET NOCOUNT ON;
	select ll.SRLotLane, a.CustName,
	case when IsNumeric(ll.SRLot)=1 then Cast(ll.SRLot as int) else 0 end as LotSortValue, SRPropID+'|'+isnull(CustID,'') as PropIDBarCustId	
	from 
		[tblInput-SROA] s  inner join
		[tblArCust] a on s.fkISCustID=a.CustID inner join
		[tbllotlane_master] ll on s.fkISPropId=ll.SRPropId 
	Order by 
		LotSortValue, SRLane
end
GO
