SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 4/11/2016
-- Description:	Data for Submittal History report Lot/Lane Dropdown
/*
	exec uspSubmittalHistoryLotLaneDropdown
*/
-- =============================================
alter PROCEDURE uspSubmittalHistoryLotLaneDropdown 
AS
BEGIN
	SET NOCOUNT ON;
		SELECT DISTINCT s.Lot+'|'+s.Lane as LotLaneKey, s.Lot + ' - ' + s.Lane as LotLaneDisplay, s.Lot, s.Lane,
			case when isnumeric(replace(s.Lot,',','x'))=1 then cast(s.Lot as int) else -1 end as lotForSortingPurposes
			--0 as lotForSortingPurposes
		FROM tblSubmittal s
		WHERE s.Lot is not null and s.Lane is not null
		ORDER BY s.Lane,lotForSortingPurposes
END
GO
