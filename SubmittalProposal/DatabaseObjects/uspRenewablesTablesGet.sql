USE [Renewables]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jason Schneider
-- Create date: 7/14/2018
-- Description:	Gets the tables of Renewables
-- =============================================
alter PROCEDURE uspRenewablesTablesGet
AS
BEGIN
	SET NOCOUNT ON;
	Select * from OwnerConcerns.dbo.[tblDepartment{LU}];
	select * from [tblDocType{LU}] order by DocName;
	select * from tblRenewables t left outer join 
		OwnerConcerns.dbo.[tblDepartment{LU}] d on isnull(d.Department,'')=isnull(t.SROADepartment,'')
	select * from [tblTermOfRenewable{LU}]
END
GO
