SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 5/11/2016
-- Description:	Data for Envelope
/*
	exec uspRptContractorMailingEnvelope @SRContrRegID=1
*/
-- =============================================
alter PROCEDURE uspRptContractorMailingEnvelope 
	@SRContrRegID int=null

AS
BEGIN
	if @SRContrRegID is null begin
		select 
			cast(1 as int) as SRContrRegID,
			cast('' as nvarchar(70)) as Company,
			cast('' as nvarchar(40)) as MailAddr1,
			cast('' as nvarchar(40)) as MailAddr2,
			cast('' as nvarchar(30)) as City,
			cast('' as nvarchar(2)) as State,
			cast('' as nvarchar(10)) as Zip
	end else begin
		SELECT 
			SRContrRegID,
			Company,
			MailAddr1,
			MailAddr2,
			City,
			[State],
			Zip	
		FROM tblContractors c
		WHERE SRContrRegID=@SRContrRegID
	end
END
GO
