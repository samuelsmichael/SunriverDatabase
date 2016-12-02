USE [ID-Card_Split_FE]
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 06/11/2015
-- Description:	Gets the Cardholder Address
/*
	exec uspAddressGet @PropId='25155'
*/
-- =============================================
alter PROCEDURE uspAddressGet (
	@PropId nvarchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	select srlotlane,dc_address, SRPropID, SRLot, SRLane from [tbllotlane_master] where srPropId=@PropId
end
GO
