SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description: Get available spaces
-- =============================================
alter PROCEDURE uspAvailableSpaces 
AS
BEGIN
	SET NOCOUNT ON;
SELECT t.tSISpace, t.SpaceLeased, t.tSISpaceSize, t.tSIElectServ, v.AnnualRent
FROM [tblSpaceInfo{LU}] t LEFT OUTER JOIN vFindRent v ON t.tSISpace = v.tSISpace
WHERE (((t.SpaceLeased)=0));

END
GO
