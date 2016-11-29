USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspSROALaborDelete]    Script Date: 11/27/2016 3:42:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/11/2015
-- Description:	Deletes Labor
/*
	exec uspSROALaborDelete
*/
-- =============================================
create PROCEDURE [dbo].[uspSROALaborDelete] 
	@VWOLaborID int
AS
BEGIN
	delete from tblVWOLabor where VWOLaborID=@VWOLaborID
END

