SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/11/2016
-- Description:	Data for Contractor by Category report
/*
	exec uspRptContractorList @RegistrationStartDate='1/1/2014', @RegistrationEndDate='12/31/2015', @ListYear='2015'
*/
-- =============================================
alter PROCEDURE uspRptContractorList 
	@RegistrationStartDate datetime,
	@RegistrationEndDate datetime,
	@ListYear varchar(4)

AS
BEGIN
	if @RegistrationStartDate is null begin
		select
			cast (1 as int) as SRContrRegID,
			cast (getdate() as datetime) as Reg_Date,
			cast ('' as nvarchar(70)) as Company,
			cast ('' as nvarchar(50)) as Contact,
			cast ('' as nvarchar(14)) as Phone_1,
			cast ('' as nvarchar(14)) as Phone_2,
			cast ('' as nvarchar(14)) as Active
	end else begin
		SELECT c.SRContrRegID, c.Reg_Date, c.Company, c.Contact, c.Phone_1, c.Phone_2, c.Active
		FROM tblContractors c
		WHERE 
			c.Reg_Date Between @RegistrationStartDate and @RegistrationEndDate
		ORDER BY c.Company
	end
END
GO
