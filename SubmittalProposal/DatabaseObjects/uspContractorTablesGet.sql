SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets the tables of Contractor
-- =============================================
alter PROCEDURE uspContractorTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	Select * from [tblContractorCategories{LU}] order by Category;
	select * from tblContractors order by Company;
END
GO
