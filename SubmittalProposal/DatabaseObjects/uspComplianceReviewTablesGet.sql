SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets the tables of ComplianceReview
-- =============================================
CREATE PROCEDURE uspComplianceReviewTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	Select * from tblComplianceReview;
	select * from tblComplianceLetterData;
END
GO
