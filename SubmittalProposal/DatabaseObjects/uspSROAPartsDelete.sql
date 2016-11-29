USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspSROAPartsDelete]    Script Date: 11/27/2016 3:45:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Deletes Parts
/*
	exec uspSROAPartsDelete
*/
-- =============================================
create PROCEDURE [dbo].[uspSROAPartsDelete] 
	@VWOPartID int
AS
BEGIN
	delete from tblVWOParts where VWOPartID=@VWOPartID
END

