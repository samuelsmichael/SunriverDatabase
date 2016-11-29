USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspSROAServiceDelete]    Script Date: 11/27/2016 3:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/24/2016
-- Description:	Deletes Service
/*
	exec uspSROAServiceDelete
*/
-- =============================================
create PROCEDURE [dbo].[uspSROAServiceDelete] 
	@VWOServiceID int
AS
BEGIN
	delete from tblVWOServices where VWOCtrServID=@VWOServiceID
END

