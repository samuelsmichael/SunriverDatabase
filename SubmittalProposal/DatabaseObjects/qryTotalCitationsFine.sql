USE [SRCitations]
GO

/****** Object:  View [dbo].[qryTotalCitationFine]    Script Date: 4/23/2016 3:58:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[qryTotalCitationFine]
AS
SELECT        fkCitationID, SUM(ISNULL(ScheduleFine, 0)) AS TotalCitationFine, CAST(SUM(ISNULL(ScheduleFine, 0) / 2) AS money) AS PrePayAmount
FROM            dbo.tblViolations AS v
GROUP BY fkCitationID

GO
