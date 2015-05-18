SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/11/2016
-- Description:	Data for Contractor by Category report
/*
	exec uspRptContractorMailLabels @RegistrationStartDate='1/1/2014', @RegistrationEndDate='12/31/2015'
*/
-- =============================================
alter PROCEDURE uspRptContractorMailLabels 
	@RegistrationStartDate datetime=null,
	@RegistrationEndDate datetime=null

AS
BEGIN
	if @RegistrationStartDate is null begin
		select
			cast (1 as int) as SRContrRegID,
			cast (getdate() as datetime) as Reg_Date,
			cast ('' as nvarchar(70)) as Company,
			cast ('' as nvarchar(50)) as Contact,
			cast('' as nvarchar(40)) as MailAddr1,
			cast('' as nvarchar(40)) as MailAddr2,
			cast('' as nvarchar(30)) as City,
			cast('' as nvarchar(2)) as [State],
			cast('' as nvarchar(10)) as Zip
	end else begin

		SELECT SRContrRegId, Reg_Date, Company, Contact, MailAddr1, MailAddr2, City, [State], Zip
		FROM tblContractors c
		WHERE 
			c.Reg_Date Between @RegistrationStartDate and @RegistrationEndDate
		ORDER BY c.Company
	end
END
GO
