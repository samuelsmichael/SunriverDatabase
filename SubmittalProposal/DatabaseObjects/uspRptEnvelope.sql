SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/22/2017
-- Description:	The Envelope.rpt doesn't use a table, and so it doesn't
--				fit the new model we had to employ ... by which model we simply pass the dataset to the report.
--				This is a kind of dummy report in that it simply takes parms and returns a dataset.
-- =============================================
use [ID-Card_Split_FE]
go
alter PROCEDURE uspRptEnvelope 
	@Name nvarchar(50)=null,
	@Address1 nvarchar(50)=null,
	@Address2 nvarchar(50)=null,
	@City nvarchar(50)=null,
	@State nvarchar(2)=null,
	@Zip nvarchar(10)=null,
	@ReturnAddressName nvarchar(50)=null,
	@ReturnAddressAddress nvarchar(50)=null,
	@ReturnAddressCity nvarchar(50)=null,
	@ReturnAddressState nvarchar(2)=null,
	@ReturnAddressZip nvarchar(10)=null,
	@SunriverAddress nvarchar(50)=null
AS
BEGIN
	SET NOCOUNT ON;
	if @Name is null and @Address1 is null and @Address2 is null and @City is null begin -- that's enough
		select 
			cast ('' as varchar(50)) as Name,
			cast ('' as varchar(50)) as Address1,
			cast ('' as varchar(50)) as Address2,
			cast ('' as varchar(50)) as City,
			cast ('' as varchar(2)) as [State],
			cast ('' as varchar(10)) as ZIP,
			cast ('' as varchar(50)) as ReturnAddressName,
			cast ('' as varchar(50)) as ReturnAddressAddress,
			cast ('' as varchar(50)) as ReturnAddressCity,
			cast ('' as varchar(2)) as ReturnAddressState,
			cast ('' as varchar(10)) as ReturnAddressZip,
			cast ('' as varchar(50)) as SunriverAddress
	end else begin
		select 
			@Name as Name,
			@Address1 as Address1,
			@Address2 as Address2,
			@City as City,
			@State as [State],
			@Zip as ZIP,
			@ReturnAddressName as ReturnAddressName,
			@ReturnAddressAddress as ReturnAddressAddress,
			@ReturnAddressCity as ReturnAddressCity,
			@ReturnAddressState as ReturnAddressState,
			@ReturnAddressZip as ReturnAddressZip,
			@SunriverAddress as SunriverAddress
	END
END
GO
