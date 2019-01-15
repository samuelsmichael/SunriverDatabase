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
exec uspRenewablesGetByProjectGet @ProjectName='Build Renewables Database II'
*/
-- =============================================
Create PROCEDURE uspRenewablesGetByProjectGet
	@ProjectName nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	select * from tblRenewables where ProjectName=@ProjectName;
END
GO
