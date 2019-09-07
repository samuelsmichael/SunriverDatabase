USE [ID-Card_Split_FE]
GO

/****** Object:  View [dbo].[sunowa_Club_Member_qryMember]    Script Date: 9/6/2019 6:47:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[sunowa_Club_Member_qryMember]
AS
SELECT        *
,RIGHT(ltrim(rtrim([Member Code])),6) as [Member Code2]
,RIGHT(ltrim(rtrim(AddressLine3)),2) as [State]
,CASE WHEN charindex(',',AddressLine3) <= 0 then '' else LEFT(AddressLine3,charindex(',',AddressLine3)-1) end as City

FROM  SUNOWA_ClubDataMart.dbo.[sunowa_Club_Members_0001a_All_Custom Fields]
WHERE [Member Code] not like '%[a-z]%'
GO

