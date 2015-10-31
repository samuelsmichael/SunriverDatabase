SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description: Data for report SpaceInventory
-- =============================================
alter PROCEDURE uspRptSpaceInventory 
AS
BEGIN
	SELECT s.[tSISpace], L.[tRVDSpace], L.[FirstName], L.[LastName], L.[RVType], L.[RVMake], L.[RVModel], L.[VehLics#],
		Isnull(FirstName,'') + ' ' + isnull(LastName,'') as LeasorsName
	FROM [tblSpaceInfo{LU}] s LEFT JOIN [vLeaseActiveInventory] L ON s.[tSISpace]=L.[tRVDSpace]
	ORDER BY s.[tSISpace];
END
GO
