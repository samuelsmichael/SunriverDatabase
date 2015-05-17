SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/11/2016
-- Description:	Data for Categorie report
/*
	exec uspRptContractorCategories @RevisionDate='12/31/2015'
*/
-- =============================================
alter PROCEDURE uspRptContractorCategories 
	@RevisionDate datetime=null

AS
BEGIN
	if @RevisionDate is null begin
		select cast('' as nvarchar(35)) as Category
	end else begin
		SELECT c.Category
		FROM [tblContractorCategories{LU}] c
		ORDER BY c.Category;
	end
END
GO
