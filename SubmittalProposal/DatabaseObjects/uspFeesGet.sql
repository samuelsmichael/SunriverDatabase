SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 9/07/2015
-- Description:	Gets the tables of Fee List
-- =============================================
alter PROCEDURE uspFeesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select * from [tblFeeList{LU}]
END
GO
