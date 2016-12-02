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
alter PROCEDURE uspOwnerConcernsQueriesFromSRProperty 	
	@Lot nvarchar(20) = null
	,@Lane nvarchar(30) = null
AS
BEGIN
	declare @LotLane nvarchar(50)
	set @LotLane= @Lot + ' ' + @Lane
	exec OwnerConcerns..uspOwnerConcernsQueries @SRLotLane=@LotLane  
END
GO
