USE SRPropertySQL

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Gets the data for OwnerConcerns Queries
/*
	exec uspOwnerConcernsQueriesFromSRProperty  @Lot ='5', @Lane='Shadow'
*/
-- =============================================
use srpropertysql
go
alter PROCEDURE uspOwnerConcernsFetchTheReportHeading 	
	@Lot nvarchar(20) = null -- dummy
	,@Lane nvarchar(30) = null -- dummy
	,@PropID nvarchar(10) = null --dummy
	,@ReportHeading nvarchar(256)

AS
BEGIN
	select top 1 @ReportHeading AS ReportHeading FROM tblBPData
END
GO
