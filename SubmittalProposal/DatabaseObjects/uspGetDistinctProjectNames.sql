USE [Renewables]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Samuels
-- Create date: 12/31/2018
-- Description:	Gets the tables of Renewables by ProjectName

/*
exec uspGetDistinctProjectNames
*/
-- =============================================
Create PROCEDURE uspGetDistinctProjectNames
AS
BEGIN
	SET NOCOUNT ON;
	select distinct ProjectName from tblRenewables
END
GO
