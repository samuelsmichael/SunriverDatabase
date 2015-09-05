SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Gets the tables of Sell Check
-- =============================================
alter PROCEDURE uspSellCheckTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select *, dbo.udfCommaDelimitedRepresentationOfInspectionIDs(scRequestID) inspectionIDs, CONVERT(VARCHAR(10), scLTDate, 112) as DateYYYYMMDD from tblRequest 
	Select * from tblSellCheck;
END
GO
