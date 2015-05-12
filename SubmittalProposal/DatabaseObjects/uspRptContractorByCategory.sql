SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/11/2016
-- Description:	Data for Contractor by Category report
/*
	exec uspRptContractorByCategory @RegistrationStartDate='1/1/2015', @ListRevisionDate='4/19/2015', @ListYear='2015'
*/
-- =============================================
alter PROCEDURE uspRptContractorByCategory 
	@RegistrationStartDate datetime,
	@ListRevisionDate datetime,
	@ListYear varchar(4)

AS
BEGIN
	if @RegistrationStartDate is null begin
		select
			cast(1 as int) as SRContrRegID,
			cast('' as nvarchar(35)) as Category,
			cast('' as nvarchar(70)) as Company,
			cast(getdate() as datetime) as Reg_Date,
			cast('' as nvarchar(14)) as Phone_1,
			cast('' as nvarchar(14)) as Phone_2,
			cast('' as nvarchar(8)) as Lic_Number,
			cast('' as nvarchar(35)) as CAT_1,
			cast('' as nvarchar(35)) as CAT_2,
			cast('' as nvarchar(35)) as CAT_3,
			cast('' as nvarchar(35)) as CAT_4
	end else begin
		SELECT 
				c.SRContrRegID, a.Category, c.Company, c.Reg_Date, c.Phone_1, c.Phone_2, c.Lic_Number, c.CAT_1, c.CAT_2, c.CAT_3, c.CAT_4
			FROM tblContractors c, [tblContractorCategories{LU}] a
		WHERE 
			(((a.Category)=[CAT_1]) AND ((c.Reg_Date)>=@RegistrationStartDate)) OR 
			(((a.Category)=[CAT_2]) AND ((c.Reg_Date)>=@RegistrationStartDate)) OR 
			(((a.Category)=[CAT_3]) AND ((c.Reg_Date)>=@RegistrationStartDate)) OR 
			(((a.Category)=[CAT_4]) AND ((c.Reg_Date)>=@RegistrationStartDate))
		ORDER BY Category, Company
	end
END
GO
