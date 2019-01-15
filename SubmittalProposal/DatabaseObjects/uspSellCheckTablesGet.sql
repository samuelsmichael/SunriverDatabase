SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Gets the tables of Sell Check
-- =============================================
use SRSellCheck
go
alter PROCEDURE uspSellCheckTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select *, dbo.udfCommaDelimitedRepresentationOfInspectionIDs(scRequestID) inspectionIDs, CONVERT(VARCHAR(10), scLTDate, 112) as DateYYYYMMDD from tblRequest 
	Select *, dbo.udfCommaDelimitedRepresentationOfFollowUpIDs(scInspectionID) followupIDs, dbo.[udfBarDelimitedRepresentationOfFollowUpDescriptions](scInspectionID) FollowUpDescriptions from tblSellCheck;
	select * from tblSellCheckFollowUp
END
GO
