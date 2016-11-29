USE [SROAVehicleMaintenance]
GO
/****** Object:  StoredProcedure [dbo].[uspSROAFindHighestWordOrderNumber]    Script Date: 11/27/2016 3:40:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/25/2016
-- Description:	Finds the highest-most key in tblVWOData, and returns its integer component
/*
	declare @HighestInt int
	exec uspSROAFindHighestWordOrderNumber @HighestInt out
	print cast(@HighestInt as varchar)
*/
-- =============================================
CREATE PROCEDURE [dbo].[uspSROAFindHighestWordOrderNumber] 
	@HighestWorkOrderIntergerComponent int out
AS
BEGIN
	declare @HighestVWOID nvarchar(10),
			@LocationOfDash int
	select top 1 @HighestVWOID=VWOID from tblVWOData order by VWOID desc
	set @LocationOfDash=CHARINDEX('-',@hIGHESTvwoid)
	SELECT @HighestWorkOrderIntergerComponent=CAST(SUBSTRING(@HighestVWOID,@LocationOfDash+1,9999) as int)
END

