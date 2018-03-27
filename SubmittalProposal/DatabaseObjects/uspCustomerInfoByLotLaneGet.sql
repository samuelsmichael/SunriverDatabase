-- ================================================
USE [ID-Card_Split_FE]
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

	SELECT 
		case when IsNumeric(SRLot)=1 then Cast(SRLot as int) else 0 end as LotSortValue, 
		qryLotLaneWithOwners_Master.LotLane as SRLotLane, 
		qryLotLaneWithOwners_Master.PrimaryOwner as CustName,
		SRPropID+'|'+isnull(CustID,'') as PropIDBarCustId
	FROM qryLotLaneWithOwners_Master
	WHERE LotLane is not null
	ORDER BY LotSortValue, qryLotLaneWithOwners_Master.SRLane, qryLotLaneWithOwners_Master.SRLot

end
GO
