SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 10/20/2015
-- Description:	Is space already leased 
/*
	declare @RVLeaseID int,
			@Name nvarchar(51),
			@Space nvarchar(10)
	set @Space='C 11'
	exec uspSpaceLeased @Space=@Space, @RVLeaseID=@RVLeaseID out, @Name=@Name out
	print '@RVLeaseID= ' + cast(@RVLeaseID as varchar)
	print '@Name= ' + @Name 
	SELECT * FROM tblRVData WHERE TRVDSPACE=@Space
*/
-- =============================================
ALTER PROCEDURE uspSpaceLeased 
	@Space nvarchar(10),
	@RVLeaseID int out,
	@Name nvarchar(51) out
AS
BEGIN
	SET NOCOUNT ON;
	declare @RVLeaseIdData int,
			@NameData nvarchar(51),
			@FirstName nvarchar(25),
			@LastName nvarchar(25);
	select top 1 @RVLeaseIdData=RVLeaseID, @NameData=isnull(FirstName,'') + ' ' + isnull(LastName,'')
	from tblRVData
	where LeaseCancelled = 0 and tRVDSpace=@Space
	set @RVLeaseID=@RVLeaseIDData
	set @Name=@NameData
END
GO
