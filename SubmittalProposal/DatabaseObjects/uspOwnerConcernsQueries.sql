USE OwnerConcerns

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/14/2016
-- Description:	Gets the data for OwnerConcerns Queries
/*
	exec uspOwnerConcernsQueries  @SRLotLane='5 Shadow'
	exec uspOwnerConcernsQueries  @DeptReferred='Environmental', @ReportTitle='Environmental - All Owner Concerns', @BaseDirForPhotos='C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns'
*/
-- =============================================
use OwnerConcerns;
go
alter PROCEDURE uspOwnerConcernsQueries 
	@DeptReferred nvarchar(30)=null
	,@StartDate datetime=null
	,@EndDate datetime=null
	,@ConcernsOpen222 bit = null
	,@Category nvarchar(30) = null
	,@ForceSortByCategory bit = null
	,@ButIncludeBothOpensAndClosedInTheDataSet bit = null
	,@JustDoingCategorySummary bit = null
	,@SRLotLane nvarchar(50) = null
	,@ReportTitle nvarchar(128) = null
	,@BaseDirForPhotos nvarchar(2000)=null
AS
BEGIN
	SET NOCOUNT ON;

	declare @cmdString varchar(2000)
	declare @cmdString2 varchar(2000)
	set @cmdString = 'dir ' + @BaseDirForPhotos
	declare @photos table (
		OCCase#Photos int,
		URI nvarchar(max)
	)
    declare @tab TABLE (
		rid int NOT NULL IDENTITY(1,1),
		xpout varchar(2000)
	)
	declare @tab2 TABLE (
		rid2 int NOT NULL IDENTITY(1,1),
		xpout2 varchar(2000)
	)
    
	INSERT INTO @tab
    EXEC master..xp_cmdshell @cmdString
	--select * From @tab

	Declare @rid int,
			@xpout varchar(2000),
			@dirName varchar(max),
			@rid2 int,
			@xpout2 varchar(2000),
			@fullFileSpec varchar(max)
	while exists(select * from @Tab) begin
		select top 1 @rid=rid, @xpout=xpout from @tab
		if @xpout like '%<DIR>%' and @xpout not like '%.%' begin
		-- 10/13/2017  06:57 AM    <DIR>          142
			SELECT @dirName = ltrim(RTRIM(SUBSTRING(@xpout, 39, 10)))
			--print '@dirName='+@dirName
			set @cmdString2 = ' dir ' + 'C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns\'+@dirName
			--print '@cmdString2='+@cmdString2
			INSERT INTO @tab2
			EXEC master..xp_cmdshell @cmdString2
			--10/09/2017  07:30 AM         1,084,554 scan0001.jpg
			--10/13/2017  01:00 PM                 6 HiMom.txt
			--select * From @tab2
			while exists(select * from @Tab2) begin
				select top 1 @rid2=rid2, @xpout2=xpout2 from @tab2
				if @xpout2 not like '%volume%' and @xpout2 not like '%dir%' and @xpout2 not like '%null%'  and @xpout2 not like '%byte%' begin
					select @fullFileSpec = @BaseDirForPhotos + '\' + @dirName+'\'+ltrim(RTRIM(SUBSTRING(@xpout2,40,1000)))
					--print '@fullFileSpec='+@fullFileSpec
					insert into @photos
					select cast(@dirName as int), @fullFileSpec
				end
				delete from @Tab2 where rid2=@rid2
			end
		end
		delete from @tab where rid=@rid
	end
	--select * from @photos
	/*
-- To allow advanced options to be changed.  
EXEC sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO  
*/

/*
	insert into @photos
	select 183, 'C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns\142\scan0005.jpg'
	insert into @photos
	select 183, 'C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns\142\scan0001.jpg'
	insert into @photos
	select 451, 'C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns\28\scan0004.jpg'
	insert into @photos
	select 451, 'C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns\241\MyEnneagram6.jpg'
*/

SELECT 
	ROW_NUMBER() OVER(PARTITION BY OCCase# ORDER BY OCCase# ASC) 
		AS Row#,uri,
	c.[OCCase#], c.DeptReferred1,  c.SubmitDate, c.ResolutionDate, c.FirstName, c.LastName, case when c.ResolutionDate is null then 'Yes' else 'No' end as [Open],
		m.AddressLine5 AS SRLane, 
	c.Category, c.[Description], c.Resolution, c.CloseFormBy, c.DeptReferred2, 
	 @StartDate as StartDate, @EndDate as EndDate, @ReportTitle as ReportTitle,@ConcernsOpen222 as ConcernsOpen222,
	 @JustDoingCategorySummary as JustDoingCategorySummary
FROM 
	[ID-Card_Split_FE]..sunowa_Club_Member_qryMember m INNER JOIN 
	tblOCData c ON m.[Member Code2] = c.[OwnerID#]
	Left Outer Join @photos p ON p.OCCase#Photos=c.OCCase#
WHERE 
	(@DeptReferred is null or c.DeptReferred1=@DeptReferred) 
	AND (@StartDate is null or c.SubmitDate>=@StartDate)
	AND (@EndDate is null or c.SubmitDate<DateAdd(d,1,@EndDate))
	AND (@Category is null or @Category=Category)
	AND (@ConcernsOpen222 is null or @ButIncludeBothOpensAndClosedInTheDataSet=1 or (
		((@ConcernsOpen222=1 and ResolutionDate is null) or
		(@ConcernsOpen222=0 and ResolutionDate is not null))	
	))                                                                   
	AND (@SRLotLane is null or m.AddressLine5 like @SRLotLane + '%')
ORDER BY 
	CASE WHEN @ForceSortByCategory is not null and  @ForceSortByCategory=1 then c.Category end,
	CASE WHEN @DeptReferred is null and @ForceSortByCategory is null then c.DeptReferred1 end,
	case when @Category is null then c.Category end,
	c.[OCCase#],
	Row#
END
GO
