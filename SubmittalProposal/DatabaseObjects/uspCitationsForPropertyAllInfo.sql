USE [SRPropertySQL]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 12/02/2016
-- Description:	Gets Citation info for Property-all-info
/*
	exec uspCitationsForPropertyAllInfo @Lot='3', @Lane='Squirrel'
*/
-- =============================================
Use srpropertysql
go
alter PROCEDURE uspCitationsForPropertyAllInfo 
	@ReportHeading nvarchar(256)=null,
	@Lot nvarchar(20),
	@Lane nvarchar(30),
	@PropID nvarchar(10) -- dummy

AS
BEGIN
	SET NOCOUNT ON;
	select CitationID, VLastName, VFirstName, OffenseDate, OffenseLocation, FineStatus
	from SRCitations..tblCitations
	where
		OffenseLocation = @Lot + ' ' + @Lane
end
GO
