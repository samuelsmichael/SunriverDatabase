SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/11/2016
-- Description:	Data for Compliance History report Lot/Lane Dropdown
/*
	exec uspComplianceHistoryLotLaneDropdown
*/
-- =============================================
alter PROCEDURE uspComplianceHistoryLotLaneDropdown 
AS
BEGIN
	SET NOCOUNT ON;
		SELECT DISTINCT crLOT+'|'+crLANE as LotLaneKey, crLOT + ' - ' + crLANE as LotLaneDisplay, crLot, crLane,
			case when isnumeric(replace(crLot,',','x'))=1 then cast(crLot as int) else -1 end as crLotForSortingPurposes
		FROM tblComplianceReview cr
		WHERE crLot is not null and crLane is not null
		ORDER BY crLANE,crLotForSortingPurposes
END
GO
