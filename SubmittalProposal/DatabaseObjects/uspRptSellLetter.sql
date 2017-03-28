SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Sell Check Letter 
/*
	exec uspRptSellLetter 1946, 'Mike Samuels', 'Programmer'
*/
-- =============================================
use SRSellCheck;
go
alter PROCEDURE uspRptSellLetter
	@InspectionId int,
	@Employee nvarchar(64) = null,
	@Title nvarchar(64) = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT r.scLot, r.scLane, r.scLTRecipient,r.scLTMailAddr1,r.scLTMailAddr2,r.scLTCity,r.scLTState, r.scLTZip, r.scLTCCopy1, r.scLTCCopy2, r.scLTCCopy3,  sc.*,
	@Employee as Employee, @Title as [Title]
	FROM [SRSellCheck].[dbo].tblsellcheck sc inner join tblRequest r on r.scRequestId=sc.fkscRequestId
	WHERE scInspectionID=@InspectionId
END
GO
