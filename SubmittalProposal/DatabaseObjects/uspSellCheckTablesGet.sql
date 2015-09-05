SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mike Samuels
-- Create date: 3/11/2015
-- Description:	Gets the tables of Sell Check
-- =============================================
alter PROCEDURE uspSellCheckTablesGet 
AS
BEGIN
	SET NOCOUNT ON;
	select * from tblRequest;
	Select * from tblSellCheck;
END
GO
