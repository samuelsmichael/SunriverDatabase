SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jason Schneider
-- Create date: 7/14/2018
-- Description:	Gets the tables of Renewables
-- =============================================
Create PROCEDURE uspRenewablesTablesGet
AS
BEGIN
	SET NOCOUNT ON;
	Select * from OwnerConcerns.dbo.[tblDepartment{LU}];
	select * from [tblDocType{LU}];
	select * from tblRenewables;
END
GO
