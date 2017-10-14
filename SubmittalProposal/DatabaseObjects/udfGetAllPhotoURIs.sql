USE OwnerConcerns
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/13/2017
-- Description:	Creates a table of all of the URIs of all of the Owner Concerns photos
-- =============================================
CREATE FUNCTION [dbo].udfGetAllPhotoURIs (
	@BaseDir nvarchar(max)
)
RETURNS 
	 @photos table (
		OCCase#Photos int,
		URI nvarchar(max)
	)

AS
BEGIN

set @BaseDir = 'C:\Temp\Sunriver\SunriverDatabase\SubmittalProposal\Images\ownerconcerns'


	declare @cmdString varchar(2000)
	declare @cmdString2 varchar(2000)
	set @cmdString = 'dir ' + @BaseDir
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
			--select * From @tab2
			--10/09/2017  07:30 AM         1,084,554 scan0001.jpg
			--10/13/2017  01:00 PM                 6 HiMom.txt
		end
		delete from @tab where rid=@rid
	end
	while exists(select * from @Tab2) begin
		select top 1 @rid2=rid2, @xpout2=xpout2 from @tab2
		if @xpout2 not like '%volume%' and @xpout2 not like '%dir%' and @xpout2 not like '%null%' begin
			select @fullFileSpec = @BaseDir + '\' + @dirName+'\'+ltrim(RTRIM(SUBSTRING(@xpout2,40,1000)))
			--print '@fullFileSpec='+@fullFileSpec
			insert into @photos
			select cast(@dirName as int), @fullFileSpec
		end
		delete from @Tab2 where rid2=@rid2
	end
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
	
	RETURN 
END
GO