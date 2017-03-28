SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/11/2016
-- Description:	Data for Contractors All Data report
/*
	exec uspRptContractorsAllData @RegistrationStartDate='1/1/2014'
*/
-- =============================================
use contractorregsql;
go
alter PROCEDURE uspRptContractorsAllData 
	@RegistrationStartDate datetime,
	@ListYear varchar(4)


AS
BEGIN
	if @RegistrationStartDate is null begin
		select 
			cast(1 as int) as SRContrRegID,
			cast(getdate() as datetime) as Reg_Date,
			cast('' as nvarchar(70)) as Company,
			cast('' as nvarchar(50)) as Contact,
			cast('' as nvarchar(40)) as MailAddr1,
			cast('' as nvarchar(40)) as MailAddr2,
			cast('' as nvarchar(20)) as City,
			cast('' as nvarchar(2)) as [State],
			cast('' as nvarchar(10)) as ZIP,
			cast('' as nvarchar(14)) as Phone_1,
			cast('' as nvarchar(14)) as Phone_2,
			cast('' as nvarchar(14)) as Fax,
			cast('' as nvarchar(40)) as Email,
			cast('' as nvarchar(14)) as Active,
			cast('' as nvarchar(8)) as Lic_Number,
			cast(getdate() as datetime) as Lic_X_Date,
			cast('' as nvarchar(35)) as CAT_1,
			cast('' as nvarchar(35)) as CAT_2,
			cast('' as nvarchar(35)) as CAT_3,
			cast('' as nvarchar(35)) as CAT_4,
			cast('' as ntext) as Comment,
			cast('4/19/2011' as datetime) as RegistrationStartDate,
			cast('2017' as varchar(4)) as ListYear
	end else begin
		SELECT c.SRContrRegID, c.Reg_Date,c.Company, c.Contact, c.MailAddr1, c.MailAddr2, c.City, c.State, c.ZIP, c.Phone_1, c.Phone_2, c.Lic_Number, c.Lic_X_Date, c.CAT_1, c.CAT_2, c.CAT_3, c.CAT_4, c.Comment,
			@RegistrationStartDate as RegistrationStartDate, @ListYear as ListYear
		FROM tblContractors c
		WHERE (((c.Reg_Date)>=@RegistrationStartDate))
		ORDER BY c.Company;
	end
END
GO
